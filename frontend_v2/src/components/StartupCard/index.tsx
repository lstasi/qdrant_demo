import {
  Card,
  Image,
  Text,
  Badge,
  Button,
  Group,
  createStyles,
  Tooltip,
  ActionIcon,
} from "@mantine/core";
import { IconExternalLink } from "@tabler/icons-react";

type StartupCardProps = {
  data: {
    Index: number;
    _1: number;
    name: string;
    images: string;
    alt: string;
    description: string;
    link: string;
    city: string;
  };
  onClickFindSimilar: (data: string) => void;
};
export const useStyles = createStyles(() => ({
  card: {
    height: "100%",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    transition: "transform .3s ease-in-out",
  },
}));

export function StartupCard(prop: StartupCardProps) {
  const data = prop.data;
  const onClickFindSimilar = prop.onClickFindSimilar;
  const { classes } = useStyles();
  return (
    <Card
      shadow="sm"
      padding="lg"
      radius="md"
      withBorder
      key={data.Index}
      className={classes.card}
    >
      <Card.Section>
        <Image height={200} src={data.images} withPlaceholder alt={data.alt} p={10}/>
      </Card.Section>

      <Group position="apart" mt="md" mb="xs">
        <Text weight={500}>{data.name}</Text>
        <Badge color="blue" variant="light">
          {data.city}
        </Badge>
      </Group>

      <Text size="sm" color="dimmed">
        {data.description.length > 100
          ? data.description.substring(0, 80) + "..."
          : data.description}
      </Text>

      <Group position="apart" mt="md" mb="xs">
        <Button
          variant="light"
          color="pink"
          onClick={() => {
            onClickFindSimilar(data.description);
          }}
        >
          Find Similar
        </Button>
        <Tooltip label="Visit Website" position="bottom" withArrow>
          <ActionIcon
            size="lg"
            color="pink"
            variant="light"
            component="a"
            href={data.link}
            target="_blank"
          >
            <IconExternalLink size="1.1rem" stroke={1.5} />
          </ActionIcon>
        </Tooltip>
      </Group>
    </Card>
  );
}
